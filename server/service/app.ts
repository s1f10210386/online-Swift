import server from "$/$server";
import { API_BASE_PATH, CORS_ORIGIN } from "$/service/envValues";
import cookie from "@fastify/cookie";
import cors from "@fastify/cors";
import helmet from "@fastify/helmet";
import type { FastifyServerFactory } from "fastify";
import Fastify from "fastify";

export const init = (serverFactory?: FastifyServerFactory) => {
  const app = Fastify({ serverFactory });
  app.register(helmet);
  app.register(cors, { origin: CORS_ORIGIN, credentials: true });
  app.register(cookie);
  server(app, { basePath: API_BASE_PATH });

  app.get("/testtest", async () => ({ helloWorld: "testtest" }));

  app.get("/path", async (request, reply) => {
    const { message } = request.query as { message: string };
    console.log(message); // "Hello Fastify" がコンソールに表示される

    // 応答メッセージを返す
    return { reply: `Received message: ${message}` };
  });

  return app;
};
