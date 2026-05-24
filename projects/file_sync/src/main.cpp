#include "inotify.hpp"
#include <print>
#include <sys/inotify.h>
int main() {
  FileWatcher fw{};
  fw.add_watch_path("/home/cwalford/tmp/");
  inotify_event event;
  fw.read_one(event);
  std::print("mask {0}", event.mask);
  return 0;
}
