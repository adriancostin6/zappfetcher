const std = @import("std");

const ZenvArgs = struct {
    create: []const u8,
    weird: bool,
};

pub const Parser = struct {
    iterator: std.process.ArgIterator,
    args: ZenvArgs,

    pub fn init(self: *Parser, allocator: std.mem.Allocator) !void {
        self.iterator = try std.process.argsWithAllocator(allocator);
    }
    pub fn destroy(self: *Parser) void {
        self.iterator.deinit();
    }

    pub fn parse(self: *Parser) void {
        while (self.iterator.next()) |arg| {
            // this is how we process subopts
            if (std.mem.eql(u8, arg, "--create")) {
                self.args.create = self.iterator.next().?;
                continue;
            }

            if (std.mem.eql(u8, arg, "--weird")) {
                self.args.weird = true;
                continue;
            }
        }
    }
};

