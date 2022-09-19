import { Application, Router } from 'https://deno.land/x/oak@v10.1.0/mod.ts'


const app = new Application()
const router = new Router()

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
