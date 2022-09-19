import { _format } from 'https://deno.land/std@0.118.0/testing/asserts.ts'
import { Application, Router } from 'https://deno.land/x/oak@v10.1.0/mod.ts'


const router = new Router()

router.get('/data', ctx => {
    const a: number[] = new Array(16)
    for (let i = 0; i < a.length; ++i) a[i] = Math.random()
    ctx.response.body = a
})

const app = new Application()
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
