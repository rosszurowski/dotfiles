import Carbon

// This script switches macOS between different input methods (IMEs). It's
// written in Swift and pre-compiled for speed purposes. Because Raycast
// compiles Swift scripts on the fly, and this script is slow to build, I
// precompile it.
//
// Compile new versions with this command:
//
//   swiftc ./raycast/scripts/misc/switch-ime.swift -o ./raycast/scripts/misc/switch-ime
//
// Use it like this:
//
//   switch-ime list
//   switch-ime --name "Japanese" --method com.apple.inputmethod.Kotoeri.Japanese

var name: String = ""
var inputMethod: String = ""

var cmd: String = "switch"
var prevArg: String = ""
for arg in CommandLine.arguments {
  switch prevArg {
  case "name":
    prevArg = ""
    name = arg
    continue
  case "method":
    prevArg = ""
    inputMethod = arg
    continue
  default:
    break
  }
  switch arg {
  case "--name", "-n":
    prevArg = "name"
    continue
  case "--method", "-m":
    prevArg = "method"
    continue
  case "switch":
    cmd = "switch"
    continue
  case "list":
    cmd = "list"
    break
  default:
    break
  }
}

if CommandLine.arguments.count == 0 || (cmd == "switch" && (name == "" || inputMethod == "")) {
  print("Usage: switch-ime --name [name] --method [ime]")
  exit(1)
}

let sources = listRawInputSources()

if cmd == "list" {
  print("")
  print("Available input methods:")
  for source in sources {
    print("  \(extractName(of: source)) (\(extractRawIdentifier(of: source)))")
  }
  print("")
  exit(0)
}

if let source = sources.first(
  where: { extractRawIdentifier(of: $0) == inputMethod }
) {
  if selectRawInputSource(source) {
    print("Switched to \(name)")
  } else {
    print("Failed to select \(name)")
  }
} else {
  print("Missing input method: \(inputMethod)")
  exit(1)
}

func listRawInputSources() -> [TISInputSource] {
  let list =
    TISCreateInputSourceList(nil, false)
    .takeRetainedValue()
    as! [TISInputSource]

  return list.filter { source in
    let category = extractCategory(of: source)
    let keyboardInputSource = kTISCategoryKeyboardInputSource as String
    return category == keyboardInputSource && isSelectable(source)
  }
}

func extractRawIdentifier(of rawInputSource: TISInputSource) -> String {
  return Unmanaged<NSString>
    .fromOpaque(TISGetInputSourceProperty(rawInputSource, kTISPropertyInputSourceID))
    .takeUnretainedValue()
    as String
}

func isSelectable(_ rawInputSource: TISInputSource) -> Bool {
  return Unmanaged<NSNumber>
    .fromOpaque(
      TISGetInputSourceProperty(
        rawInputSource,
        kTISPropertyInputSourceIsSelectCapable)
    )
    .takeUnretainedValue()
    .boolValue
}

func extractCategory(of rawInputSource: TISInputSource) -> String {
  return Unmanaged<NSString>
    .fromOpaque(TISGetInputSourceProperty(rawInputSource, kTISPropertyInputSourceCategory))
    .takeUnretainedValue()
    as String
}

func extractName(of rawInputSource: TISInputSource) -> String {
  return Unmanaged<NSString>
    .fromOpaque(TISGetInputSourceProperty(rawInputSource, kTISPropertyLocalizedName))
    .takeUnretainedValue()
    as String
}

func selectRawInputSource(_ rawInputSource: TISInputSource) -> Bool {
  return TISSelectInputSource(rawInputSource) == noErr
}
