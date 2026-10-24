#include "raylib-cpp.hpp"

namespace {
int run(raylib::Window &window);
int draw();
} // namespace

int main() {
  int screen_width = 800;
  int screen_height = 450;
  raylib::Window window(screen_width, screen_height,
                        "raylib-cpp - basic window");
  SetTargetFPS(60);
  run(window);

  return 0;
}

namespace {
int run(raylib::Window &window) {
  while (!window.ShouldClose()) {
    draw();
  }
  return 0;
}
int draw(raylib::Window &window) {
  BeginDrawing();
  window.ClearBackground(raylib::Color::RayWhite());
  raylib::Rectangle::Draw(100, 100, 100, 100, raylib::Color::Black());
  EndDrawing();
}
} // namespace
