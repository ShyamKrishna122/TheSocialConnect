import Router from "express";
import { LikeController } from "../controllers/like.controller";

const likeRouter = Router();

//!POST
likeRouter.get("/add/:postId/:userEmail", LikeController.addLike);

//!GET
likeRouter.get("/isLiked/:postId/:userEmail", LikeController.isLikedByUser);

//!GET
likeRouter.get("/:postId", LikeController.getPostLikesCount);

//!GET
likeRouter.get("/get/:postId", LikeController.getPersonList);

//!DELETE
likeRouter.delete("/remove/:postId/:userEmail", LikeController.removeLike);

export { likeRouter };
