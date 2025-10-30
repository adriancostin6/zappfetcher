const std = @import("std");
const zenv = @import("zenv");
const zenv_args = @import("zenv-args");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator(); 

    var parser: zenv_args.Parser = undefined;
    try parser.init(allocator);
    defer parser.destroy();

    parser.parse();

    std.log.debug("create {s}", .{parser.args.create});
    if (parser.args.weird == true) {
        std.log.debug("{s}", .{"weird"});
    }
    try zenv.entry();
}
