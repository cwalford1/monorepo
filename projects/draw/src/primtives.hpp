#include <array>
#include <concepts>
#include <variant>
#include <vector>
namespace draw::rendering {
using Unit = int;
using Point = std::array<Unit, 2>;

struct Rectangle {
  Point center;
  Unit width;
  Unit height;
};

using Primitive = std::variant<Rectangle>;
using Primitives = std::vector<Primitive>;

template <typename T>
concept Decomposable = requires(T obj) {
  { obj.decompose() } -> std::same_as<Primitives>;
};

} // namespace draw::rendering
