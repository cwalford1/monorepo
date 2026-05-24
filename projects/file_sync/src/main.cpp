#include "inotify.hpp"
#include <print>
#include <sys/inotify.h>
int main() {
  FileWatcher fw{};
  fw.add_watch_path("/home/cwalford/tmp/");
  auto event = fw.read_one();
  std::println("mask {0}, {1}", event->mask, mask_string(event->mask));
  return 0;
}
