import { router as index } from "./index.js";

export default function registerRoutes(app) {
  console.log("register");
  app.use("/", index);
}
