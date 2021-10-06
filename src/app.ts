import express from "express";
import dotenv from "dotenv";
import cors from "cors";
import { authRouter } from "./routes/user.routes";
import { ConnectionOptions, createConnection } from "typeorm";
import config from "./ormconfig";
import { infoRouter } from "./routes/userInfo.routes";
import { postRouter } from "./routes/post.routes";
import { commentRouter } from "./routes/comment.routes";
import { likeRouter } from "./routes/like.routes";
import { followRouter } from "./routes/follow.routes";
import { storyRouter } from "./routes/story.routes";

dotenv.config();

createConnection(config as ConnectionOptions)
  .then(async (connection) => {
    if (connection.isConnected) {
      console.log("DB Connected");
    }
    const app = express();
    const port = process.env.PORT || 8080;
    app.use(cors());
    app.use(express.json());
    app.use(express.urlencoded({ extended: false }));

    app.set("port", port);

    app.get("/", (req, res) => {
      res.send({
        data: "The Social Connect",
        message: "Connect With Your Peers and share posts",
      });
    });

    app.use("/user", authRouter);
    app.use("/info", infoRouter);
    app.use("/post", postRouter);
    app.use("/comment", commentRouter);
    app.use("/like", likeRouter);
    app.use("/follow", followRouter);
    app.use("/story", storyRouter);

    app.listen(app.get("port"), () => {
      console.log(`Server rocking over port ${app.get("port")}`);
    });
  })
  .catch((error) => {
    console.log(error);
  });
