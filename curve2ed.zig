pub const toCurve25519 = @import("src/main.zig").toCurve25519;
pub const toEd25519 = @import("src/main.zig").toEd25519;

test {
    const std = @import("std");
    std.testing.refAllDecls(@This());

    inline for (.{
        @import("src/main.zig"),
    }) |source_file| std.testing.refAllDeclsRecursive(source_file);
}
