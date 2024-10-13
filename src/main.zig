const std = @import("std");
const testing = std.testing;
const curve25519 = std.crypto.ecc.Curve25519;
const ed25519 = std.crypto.ecc.Edwards25519;
const Fe = curve25519.Fe;

/// Convert Ed25519 to Curve25519
pub fn toCurve25519(s: [32]u8) [32]u8 {
    const curve = ed25519.fromBytes(s) catch unreachable;
    const c25519 = curve25519.fromEdwards25519(curve) catch unreachable;
    return c25519.toBytes();
}

/// Convert Curve25519 to Ed25519
pub fn toEd25519(s: [32]u8) [32]u8 {
    const curve = curve25519.fromBytes(s);
    var a = Fe.add(curve.x, Fe.one);
    a = Fe.invert(a);
    a = Fe.mul(a, Fe.sub(curve.x, Fe.one));

    return Fe.toBytes(a);
}

test "To ed25519" {
    const inputHex = "d871fc80ca007eed9b2f4df72853e2a2d5465a92fcb1889fb5c84aa2833b3b40";

    var input: [inputHex.len / 2]u8 = undefined;
    _ = std.fmt.hexToBytes(&input, inputHex) catch unreachable;

    const result = toEd25519(input);
    const hex: [64]u8 = std.fmt.bytesToHex(result, .lower);
    const expected = "534eff88b5a39478963ec070a5032db54ce7457a4bb4b4f1c73355eb48ab3473";

    try std.testing.expect(std.mem.eql(u8, &hex, expected));
}

test "To Curve25519" {
    const inputHex = "534eff88b5a39478963ec070a5032db54ce7457a4bb4b4f1c73355eb48ab3473";

    var input: [inputHex.len / 2]u8 = undefined;
    _ = std.fmt.hexToBytes(&input, inputHex) catch unreachable;

    const result = toCurve25519(input);
    const hex: [64]u8 = std.fmt.bytesToHex(result, .lower);
    const expected = "d871fc80ca007eed9b2f4df72853e2a2d5465a92fcb1889fb5c84aa2833b3b40";

    try std.testing.expect(std.mem.eql(u8, &hex, expected));
}
