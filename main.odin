package main

import rl "vendor:raylib"

WIDTH :: 1024
HEIGHT :: 768
TITLE :: "Breakout+"

MIDX :: WIDTH / 2
MIDY :: HEIGHT / 2
PADDING :: 10
GAME_SCREEN :: rl.Rectangle{PADDING, PADDING, MIDX - PADDING*2, HEIGHT}

Game :: struct {
    paddle_pos: f32,
    paddle_texture: rl.Texture,
    paddle_speed: f32
}

main :: proc() {
    rl.SetConfigFlags({.VSYNC_HINT})
    rl.InitWindow(WIDTH, HEIGHT, TITLE)

    game := Game{}
    game.paddle_texture = rl.LoadTexture("assets/paddle.png")
    game.paddle_pos = WIDTH / 4
    game.paddle_speed = 300

    for !rl.WindowShouldClose() {
        if rl.IsKeyDown(.LEFT) {
            game.paddle_pos -= game.paddle_speed * rl.GetFrameTime()
            if game.paddle_pos < PADDING do game.paddle_pos = PADDING
        }

        if rl.IsKeyDown(.RIGHT) {
            game.paddle_pos += game.paddle_speed * rl.GetFrameTime()
            if i32(game.paddle_pos) + game.paddle_texture.width > MIDX - PADDING do game.paddle_pos = f32(MIDX - PADDING - game.paddle_texture.width)

        }

        rl.BeginDrawing()
        rl.ClearBackground(rl.DARKBLUE)
        rl.DrawRectangleRec(GAME_SCREEN, rl.BLACK)
        rl.DrawTexture(game.paddle_texture, i32(game.paddle_pos), HEIGHT - 30, rl.WHITE)
        rl.EndDrawing()
    }

    rl.CloseWindow()
}