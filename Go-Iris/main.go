package main

import (
	"github.com/kataras/iris"
	"github.com/kataras/iris/context"
	"github.com/kataras/iris/middleware/logger"
	"github.com/kataras/iris/middleware/recover"
)

func main() {
	app := iris.New()

	// Logs
	app.Use(recover.New()) // HTTP errors
	app.Use(logger.New()) // Requests

	// Index route
	app.Handle("GET", "/", func(ctx context.Context) {
		ctx.HTML("<h1>It works !</h1>")
	})

	// Frisbee route
	app.Get("/ping", func(ctx context.Context) {
		ctx.WriteString("pong")
	})

	// JSON route
	app.Get("/json", func(ctx context.Context) {
		/*ctx.JSON(iris.Map {
			"success": true,
			"message": "Page was reached",
		})*/
	})

	app.Run(iris.Addr(":8080"), iris.WithoutServerError(iris.ErrServerClosed))
}
