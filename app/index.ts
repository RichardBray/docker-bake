import { Hono } from "hono";

const app = new Hono();
const fakeDB: Array<{ text: string; id: number }> = [];

app.get("/", (c) => {
  return c.text("Whish List API");
});

app.get("/wishlist", (c) => {
  return c.json([...fakeDB], 200);
});

app.post("/wishlist", async (c) => {
  const { text } = await c.req.json<{ text: string }>();
  const id = fakeDB.length + 1;
  fakeDB.push({ text, id });

  return c.json({ text, id }, 201);
});

app.delete("/wishlist/:id", (c) => {
  const id = Number(c.req.param("id"));
  const index = fakeDB.findIndex((item) => item.id === id);
  if (index === -1) {
    return c.json({ message: "Not found" }, 404);
  }
  fakeDB.splice(index, 1);
  return c.json({ message: "Deleted" }, 200);
});

app.route('api/v1', app);

export default app;
