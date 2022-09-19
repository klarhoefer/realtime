
import { Application, Router } from 'https://deno.land/x/oak@v10.1.0/mod.ts' // https://github.com/oakserver/oak


const router = new Router()

type AppState = {
    second: number
}

router.get('/data', ctx => {
    const a: number[] = new Array(64)
    for (let i = 0; i < a.length; ++i) a[i] = Math.random()
    ctx.response.body = {
        second: ++ctx.app.state.second,
        samples: a
    }
})


const state = { second: 0 }
const app = new Application<AppState>({ state })
app.use(router.routes())
app.use(router.allowedMethods())

app.use(async (ctx, next) => {
    try {
        await ctx.send({
            root: `${Deno.cwd()}/public`,
            index: 'index.html'
        })
    } catch {
        await next()
    }
})

const port = 8080

app.addEventListener('listen', _ => console.log('Listening to port', port))

await app.listen({ port })
