
#include <cassert>
#include <cerrno>
#include <cstddef>
#include <cstdint>
#include <cstring>
#include <filesystem>
#include <linux/limits.h>
#include <memory>
#include <print>
#include <sstream>
#include <string>
#include <sys/inotify.h>
#include <sys/poll.h>
#include <system_error>
#include <unistd.h>
#include <utility>
#include <vector>

static constexpr size_t MAX_EVENT_SIZE = sizeof(inotify_event) + NAME_MAX + 1;

enum class Event {
  /*  events suitable for MASK parameter of INOTIFY_ADD_WATCH.  */
  ACCESS = 0x00000001,        /* File was accessed.  */
  MODIFY = 0x00000002,        /* File was modified.  */
  ATTRIB = 0x00000004,        /* Metadata changed.  */
  CLOSE_WRITE = 0x00000008,   /* Writtable file was closed.  */
  CLOSE_NOWRITE = 0x00000010, /* Unwrittable file closed.  */
  OPEN = 0x00000020,          /* File was opened.  */
  MOVED_FROM = 0x00000040,    /* File was moved from X.  */
  MOVED_TO = 0x00000080,      /* File was moved to Y.  */
  CREATE = 0x00000100,        /* Subfile was created.  */
  DELETE = 0x00000200,        /* Subfile was deleted.  */
  DELETE_SELF = 0x00000400,   /* Self was deleted.  */
  MOVE_SELF = 0x00000800,     /* Self was moved.  */
};
// MOVE = (IN_MOVED_FROM, | IN_MOVED_TO)        /* Moves.  */
// CLOSE = (IN_CLOSE_WRITE, | IN_CLOSE_NOWRITE) /* Close.  */

static const Event AllEvents[] = {
    Event::ACCESS,        Event::MODIFY, Event::ATTRIB,      Event::CLOSE_WRITE,
    Event::CLOSE_NOWRITE, Event::OPEN,   Event::MOVED_FROM,  Event::MOVED_TO,
    Event::CREATE,        Event::DELETE, Event::DELETE_SELF, Event::MOVE_SELF};

std::string event_to_string(Event event) {
  switch (event) {
  case Event::ACCESS:
    return "ACCESS";
  case Event::MODIFY:
    return "MODIFY";
  case Event::ATTRIB:
    return "ATTRIB";
  case Event::CLOSE_WRITE:
    return "CLOSE_WRITE";
  case Event::CLOSE_NOWRITE:
    return "CLOSE_NOWRITE";
  case Event::OPEN:
    return "OPEN";
  case Event::MOVED_FROM:
    return "MOVED_FROM";
  case Event::MOVED_TO:
    return "MOVED_TO";
  case Event::CREATE:
    return "CREATE";
  case Event::DELETE:
    return "DELETE";
  case Event::DELETE_SELF:
    return "DELETE_SELF";
  case Event::MOVE_SELF:
    return "MOVE_SELF";
  }
  return "UNKNOWN";
}

std::string mask_string(const uint32_t mask) {
  std::stringstream out_stream{};
  for (auto event : AllEvents) {
    if (static_cast<uint32_t>(event) & mask) {
      out_stream << event_to_string(event) << " & ";
    }
  }
  auto string = out_stream.str();
  return string.substr(0, string.size() - 3);
}

struct InotifyEventDeleter {
  void operator()(inotify_event *ptr) const {
    delete[] reinterpret_cast<std::byte *>(ptr);
  }
};

struct INotifyEvent {
  int wd;           /* Watch descriptor.  */
  uint32_t mask;    /* Watch mask.  */
  uint32_t cookie;  /* Cookie to synchronize two events.  */
  std::string name; /* Name.  */
};

class FileWatcher {
  using FileDescriptor = int;
  using EventPtr = std::unique_ptr<inotify_event, InotifyEventDeleter>;

public:
  // TODO: use poll / epoll to read in data when it's available?
  FileWatcher() : in_fd(inotify_init1(IN_CLOEXEC | IN_NONBLOCK)), buffer_() {
    buffer_.reserve(MAX_EVENT_SIZE);
  };
  FileWatcher(const FileWatcher &) = delete;
  const FileWatcher &operator=(const FileWatcher &) = delete;
  FileWatcher(FileWatcher &&other) : in_fd(std::exchange(other.in_fd, -2)) {}
  FileWatcher &operator=(FileWatcher &&other) {
    other.in_fd = -2;
    return *this;
  }
  ~FileWatcher() {
    if (in_fd >= 0)
      close(in_fd);
  }

  void add_watch_path(const std::filesystem::path path) {
    if (inotify_add_watch(in_fd, path.c_str(), IN_ALL_EVENTS) < 0) {
      std::print("aborting as add watch returned -1. errno={0}", errno);
    }
  }

  INotifyEvent read_one() {
    buffer_all();
    poll(struct pollfd * fds, nfds_t nfds, int timeout)
  }

private:
  FileDescriptor in_fd;
  std::vector<std::byte> buffer_;
  bool is_valid() { return in_fd >= 0; }
  int n = 0;
  void buffer_all() {
    // TODO: optimize out unnecessary resizes;
    do {
      auto initial_size = buffer_.size();
      // make valid room for up to MAX_EVENT_SIZE bytes
      buffer_.resize(buffer_.size() + MAX_EVENT_SIZE);
      // read in data
      n = read(in_fd, buffer_.data() + initial_size, MAX_EVENT_SIZE);
      if (n < 0) {
        throw std::system_error(errno, std::generic_category(),
                                "Error adding inotify watch");
      }
      // trim back buffer length to initial size + new bytes
      buffer_.resize(initial_size + n);
    } while (n != 0);
  }
};
