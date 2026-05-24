
#include "c_calls.hpp"
#include <cassert>
#include <cerrno>
#include <cstdlib>
#include <filesystem>
#include <iostream>
#include <print>
#include <string>
#include <sys/inotify.h>
#include <unistd.h>
#include <utility>

class FileWatcher {
  using FileDescriptor = int;

public:
  void add_watch_path(const std::filesystem::path path) {

    if (inotify_add_watch(in_fd, path.c_str(), IN_CREATE) < 0) {
      std::print("aborting as add watch returned -1. errno={0}", errno);
    }
    assert(is_valid() && "FileWatcher used after move.");
  }

  void read_one(inotify_event &out) {
    read(in_fd, &out, sizeof(inotify_event));
  }

  FileWatcher() : in_fd(inotify_init1(IN_NONBLOCK | IN_CLOEXEC)) {};

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

private:
  FileDescriptor in_fd;
  bool is_valid() { return in_fd >= 0; }
};

int watch_file(std::string path) { return 0; }
