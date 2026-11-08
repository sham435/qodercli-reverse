# Installation

## macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/sham435/qodercli-reverse/main/install.sh | bash
```

Then:
```bash
qodercli-reverse --version
qodercli-reverse --help
```

## Windows

Run `install.ps1` in PowerShell.

## Go install (source)

```bash
go install github.com/sham435/qodercli-reverse/decompiled@latest
```

(Requires Go 1.24+)

## Development build

```bash
cd decompiled && go build -o ../.dev/qodercli .
```