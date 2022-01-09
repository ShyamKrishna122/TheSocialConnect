import Router from "express";
import { CommentController } from "../controllers/comment.controller";


const commentRouter = Router();

//!POST
commentRouter.post("/add/:postId", CommentController.addComment);

//!GET
commentRouter.get("/:postId", CommentController.getPostComments);

//!GET
commentRouter.get("/count/:postId", CommentController.getPostCommentCount);

//!DELETE
commentRouter.delete("/delete/:postId/:userEmail", CommentController.deleteComment);

export { commentRouter };
