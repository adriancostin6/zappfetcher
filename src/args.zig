const std = @import("std");

const ZenvArgs = struct {
    verbose: bool = false,
};

pub const Parser = struct {
    iterator: std.process.ArgIterator,
    args: ZenvArgs,

    pub fn init(allocator: std.mem.Allocator) !Parser {
        return Parser {
            .iterator = try std.process.argsWithAllocator(allocator),
            .args = .{},
        };
    }
    pub fn deinit(self: *Parser) void {
        self.iterator.deinit();
        self.args = undefined;
    }

    pub fn parse(self: *Parser) void {
        const eql = std.mem.eql;
        while (self.iterator.next()) |arg| {
            // this is how we process subopts
            if (eql(u8, arg, "--verbose") or eql(u8, arg, "-v")) {
                std.log.debug("Verbose mdoe detected.", .{});
                self.args.verbose = true;
            } else if (eql(u8, arg, "arg")) {
            }
        }
    }
};

