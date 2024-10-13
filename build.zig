const Build = @import("std").Build;

pub fn build(b: *Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("curve2ed", .{
        .root_source_file = b.path("curve2ed.zig"),
    });

    if (b.option(bool, "test-build", "compile tests?") orelse false) {
        const session_id_build_test = b.addTest(.{
            .name = "curve2ed_test",
            .root_source_file = b.path("curve2ed.zig"),
            .target = target,
            .optimize = optimize,
        });

        b.installArtifact(session_id_build_test);

        const run_test_cmd = b.addRunArtifact(session_id_build_test);
        // Force running of the test command even if you don't have changes
        run_test_cmd.has_side_effects = true;
        run_test_cmd.step.dependOn(b.getInstallStep());

        const test_step = b.step("test", "Run library tests");
        test_step.dependOn(&run_test_cmd.step);

        const build_only_test_step = b.step("test_build_only", "Build the tests but does not run it");
        build_only_test_step.dependOn(&session_id_build_test.step);
        build_only_test_step.dependOn(b.getInstallStep());
    }
}
