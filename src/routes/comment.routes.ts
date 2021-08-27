import Router from "express";
import { CommentController } from "../controllers/comment.controller";


const commentRouter = Router();

//!POST
commentRouter.post("/add/:postId", CommentController.addComment);

//!GET
commentRouter.get("/:postId", CommentController.getPostComments);

export { commentRouter };
