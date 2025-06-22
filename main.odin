package main

import rl "vendor:raylib"

WIDTH :: 1024
HEIGHT :: 768
TITLE :: "Breakout+"

MIDX :: WIDTH / 2
MIDY :: HEIGHT / 2

main :: proc() {
    rl.SetConfigFlags({.VSYNC_HINT})
    rl.InitWindow(WIDTH, HEIGHT, TITLE)

    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
        rl.ClearBackground(rl.BLACK)
        rl.DrawRectangle(MIDX, 0, MIDX, HEIGHT, rl.DARKBLUE)
        rl.EndDrawing()
    }

    rl.CloseWindow()
}