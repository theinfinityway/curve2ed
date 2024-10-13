# curve2ed

Simple Zig library for Curve25519 <-> Ed25519 conversion

## Install

You can install the library using [zigmod](https://github.com/nektro/zigmod).

1. Add library to `zigmod.yml`
   
   ![image](https://github.com/user-attachments/assets/5bef58b5-7feb-4c0d-aab7-c64b87f2b798)
2. [Integrate zigmod with `build.zig`](https://github.com/nektro/zigmod/blob/master/docs/tutorial.md#integrating-with-buildzig)
3. Run `zigmod fetch`

## Example

```zig
const std = @import("std");
const c2ed = @import("curve2ed");

pub fn main() !void {
    const inputHex = "d871fc80ca007eed9b2f4df72853e2a2d5465a92fcb1889fb5c84aa2833b3b40";

    var input: [inputHex.len / 2]u8 = undefined;
    _ = std.fmt.hexToBytes(&input, inputHex) catch unreachable;

    const result1 = c2ed.toEd25519(input);
    const result2 = c2ed.toCurve25519(result1);
    std.debug.print("Input: {s}\nEd25519: {s}\nCurve25519 (via library): {s}\n", .{ inputHex, std.fmt.bytesToHex(result1, .lower), std.fmt.bytesToHex(result2, .lower) });
}

```
