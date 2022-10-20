import { router as index } from "./index.js";

export default function registerRoutes(app) {
  app.use("/", index);
}
