defmodule Zodium do
  @moduledoc """
  Zig-powered libsodium bindings for Elixir.
  """

  use Zig,
    otp_app: :zigler,
    c: [link_lib: {:system, "sodium"}]

  ~Z"""
  const std = @import("std");
  const assert = std.debug.assert;

  const beam = @import("beam");
  const sodium = @cImport(@cInclude("sodium.h"));

  pub fn randombytes(size: usize) !beam.term {
    assert(sodium.sodium_init() != -1);

    const buffer = try beam.allocator.alloc(u8, size);
    defer beam.allocator.free(buffer);

    sodium.randombytes(buffer.ptr, buffer.len);

    return beam.make(buffer, .{});
  }

  const BEFORENM_BYTES = sodium.crypto_box_BEFORENMBYTES;
  const MAC_BYTES = sodium.crypto_box_MACBYTES;
  const NONCE_BYTES = sodium.crypto_box_NONCEBYTES;
  const PUBLIC_KEY_BYTES = sodium.crypto_box_PUBLICKEYBYTES;
  const SECRET_KEY_BYTES = sodium.crypto_box_SECRETKEYBYTES;

  pub const Keypair = struct {
    public: [PUBLIC_KEY_BYTES]u8 = [_]u8{ 0 } ** PUBLIC_KEY_BYTES,
    secret: [SECRET_KEY_BYTES]u8 = [_]u8{ 0 } ** SECRET_KEY_BYTES,
  };

  pub fn box_keypair() Keypair {
    assert(sodium.sodium_init() != -1);

    var pair = Keypair{};

    _ = sodium.crypto_box_keypair(&pair.public, &pair.secret);

    return pair;
  }

  pub fn box(msg: []u8, nonce: [NONCE_BYTES]u8, pk: [PUBLIC_KEY_BYTES]u8, sk: [SECRET_KEY_BYTES]u8) !beam.term {
    const ciphertext = try beam.allocator.alloc(u8, MAC_BYTES + msg.len);
    defer beam.allocator.free(ciphertext);

    const ret = sodium.crypto_box_easy(ciphertext.ptr, msg.ptr, msg.len, &nonce, &pk, &sk);
    assert(ret == 0);

    return beam.make(ciphertext, .{});
  }

  pub fn box_open(ciphertext: []u8, nonce: [NONCE_BYTES]u8, pk: [PUBLIC_KEY_BYTES]u8, sk: [SECRET_KEY_BYTES]u8) !beam.term {
    if (ciphertext.len <= MAC_BYTES) {
      return beam.make_error_pair("Not sodium-encrypted", .{});
    }

    const plaintext = try beam.allocator.alloc(u8, ciphertext.len - MAC_BYTES);
    defer beam.allocator.free(plaintext);

    const err = sodium.crypto_box_open_easy(plaintext.ptr, ciphertext.ptr, ciphertext.len, &nonce, &pk, &sk);

    if (err == 0) {
      return beam.make(.{.ok, plaintext}, .{});
    } else {
      return beam.make_error_pair(.@"failed_verification", .{});
    }
  }
  """
end
