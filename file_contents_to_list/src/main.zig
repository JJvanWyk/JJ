const std = @import("std");

pub fn file_contents_to_list (
        allocator: *std.mem.Allocator,
        relative_file_path: []const u8,
    ) !std.ArrayList(u8) {
    const file = try std.fs.cwd().openFile(relative_file_path, .{});
    defer file.close();
    const file_size = (try file.stat()).size;
    const file_buffer = try allocator.alloc(u8, file_size);
    defer allocator.free(file_buffer);
    _ = try file.readAll(file_buffer);

    var list_of_u8 = std.ArrayList(u8).init(allocator);

    for (file_buffer) |character| {
        try list_of_u8.append(character);
    }
    return list_of_u8;
}
