const std = @import("std");
const zenv = @import("zenv");
const zenv_args = @import("zenv-args");

pub const std_options: std.Options = .{
    .logFn = logFn,
    .log_level = .debug,
};
var log_level = std.log.Level.info; // don't set it based on build type
pub fn logFn(
    comptime message_level: std.log.Level,
    comptime scope: @TypeOf(.enum_literal),
    comptime format: []const u8,
    args: anytype,
) void {
    if (@intFromEnum(message_level) <= @intFromEnum(log_level)) {
        std.log.defaultLog(message_level, scope, format, args);
    }
}

pub fn main() !void {
    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator(); 

    var parser: zenv_args.Parser = try zenv_args.Parser.init(allocator);
    defer parser.deinit();

    parser.parse();
    if (parser.args.verbose) {
        log_level = std.log.Level.debug;
    }

    try zenv.entry();
}
