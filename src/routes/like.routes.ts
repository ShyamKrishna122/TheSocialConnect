import Router from "express";
import { LikeController } from "../controllers/like.controller";

const likeRouter = Router();

//!POST
likeRouter.post("/add/:postId", LikeController.addLike);

//!POST
likeRouter.post("/isLiked/:postId", LikeController.isLikedByUser);

//!GET
likeRouter.get("/:postId", LikeController.getPostLikesCount);

//!DELETE
likeRouter.delete("/remove/:postId", LikeController.removeLike);

export { likeRouter };
