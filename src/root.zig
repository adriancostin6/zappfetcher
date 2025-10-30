//! By convention, root.zig is the root source file when making a library.
const std = @import("std");

// We should ideally separate this in another module for CLI arguments
// TODO: look into it
pub fn entry() !void {
    std.log.info("{s}", .{"Hello from zenv"});
}

