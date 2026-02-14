# Proof-of-Concept Implementation of [wonderous-book](https://typst.app/universe/package/wonderous-book/) Typst book template for Quarto

This is a proof-of-concept implementation of a Quarto format extension implementing a Quarto book project using the Typst [wonderous-book](https://typst.app/universe/package/wonderous-book/) book template.

I don't intend to maintain this, so I am archiving it.

If you fork this, please share your maintained version:
* Submit it to the [official Quarto extensions](https://github.com/quarto-dev/quarto-web/tree/main/docs/extensions/listings) listing
* Add it to the [unofficial Quarto extensions](https://m.canouil.dev/quarto-extensions/about.html) listing

## Installation

```bash
quarto add gordonwoodhull/quarto-wonderous-book
```

## Usage

In your `_quarto.yml`:

```yaml
project:
  type: book

format: wonderous-book-typst
```

## Requirements

- Quarto >= 1.9.18
- The `wonderous-book` Typst package (automatically imported and bundled with [typst-gather](https://prerelease.quarto.org/docs/advanced/typst/typst-gather.html))

## Windows Users

The test directories use symlinks to the `_extensions` folder. On Windows, you may need to enable Developer Mode or run `git config --global core.symlinks true` before cloning.

## License

MIT
