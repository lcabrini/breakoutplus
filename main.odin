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
    paddle_speed: f32,
    ball_texture: rl.Texture,
    ball_pos: rl.Vector2,
    ball_v: rl.Vector2,
}

main :: proc() {
    rl.SetConfigFlags({.VSYNC_HINT})
    rl.InitWindow(WIDTH, HEIGHT, TITLE)

    game := Game{}
    game.paddle_texture = rl.LoadTexture("assets/paddle.png")
    game.paddle_pos = WIDTH / 4
    game.paddle_speed = 300
    game.ball_texture = rl.LoadTexture("assets/ball.png")
    game.ball_pos = {MIDX / 2, MIDY}
    game.ball_v = {200, 200}

    for !rl.WindowShouldClose() {
        if rl.IsKeyDown(.LEFT) {
            game.paddle_pos -= game.paddle_speed * rl.GetFrameTime()
            if game.paddle_pos < PADDING do game.paddle_pos = PADDING
        }

        if rl.IsKeyDown(.RIGHT) {
            game.paddle_pos += game.paddle_speed * rl.GetFrameTime()
            if i32(game.paddle_pos) + game.paddle_texture.width > MIDX - PADDING do game.paddle_pos = f32(MIDX - PADDING - game.paddle_texture.width)
        }

        game.ball_pos += game.ball_v * rl.GetFrameTime()
        if game.ball_pos.x < PADDING || i32(game.ball_pos.x) + game.ball_texture.width > MIDX - PADDING {
            game.ball_v.x *= -1
        }

        if game.ball_pos.y < PADDING {
            game.ball_v.y *= -1
        }

        paddle_col := rl.Rectangle{game.paddle_pos, HEIGHT - 30, f32(game.paddle_texture.width), f32(game.paddle_texture.height)}
        ball_center := game.ball_pos + {f32(game.ball_texture.width) / 2, f32(game.ball_texture.height) / 2}
        ball_radius := f32(game.ball_texture.width / 2)
        if game.ball_pos.y > HEIGHT - 30 && rl.CheckCollisionCircleRec(ball_center, ball_radius, paddle_col) {
            game.ball_v.y *= -1
            if i32(game.ball_pos.y) + game.ball_texture.height > HEIGHT - 30 do game.ball_pos.y = HEIGHT - 30 - f32(game.ball_texture.height)
        }

        rl.BeginDrawing()
        rl.ClearBackground(rl.DARKBLUE)
        rl.DrawRectangleRec(GAME_SCREEN, rl.BLACK)
        rl.DrawTexture(game.paddle_texture, i32(game.paddle_pos), HEIGHT - 30, rl.WHITE)
        rl.DrawTextureV(game.ball_texture, game.ball_pos, rl.WHITE)
        rl.EndDrawing()
    }

    rl.UnloadTexture(game.ball_texture)
    rl.UnloadTexture(game.ball_texture)
    rl.CloseWindow()
}