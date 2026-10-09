#import "@preview/conch:0.1.0": system, terminal

#show: terminal.with(
  system: system(
    hostname: "conch",
    files: (
      "hello.txt": "Hello, World!",
      "src/main.rs": "fn main() {\n    println!(\"hi\");\n}",
    ),
  ),
  user: "demo",
)

```
ls
cat hello.txt
cat src/main.rs
echo "Welcome to $SHELL!"
```
