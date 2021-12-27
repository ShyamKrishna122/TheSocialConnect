import { Router } from "express";
import { PostMediaController } from "../controllers/post_media.controller";

const postMediaRouter = Router();

//!POST
postMediaRouter.post("/add/:postId", PostMediaController.addPostMedia);

export { postMediaRouter };
