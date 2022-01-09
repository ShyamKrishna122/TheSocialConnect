import Router from "express";
import { PostController } from "../controllers/post.controller";

const postRouter = Router();

//!POST
postRouter.post("/add/:userEmail", PostController.addPost);

//!GET
postRouter.get("/:userEmail", PostController.getPosts);

//!GET
postRouter.get("/myPosts/:userEmail", PostController.showUserPosts);

//!GET
postRouter.get("/count/:userEmail", PostController.getPostCount);

//!DELETE
postRouter.delete("/delete/:postId/:userEmail", PostController.deleteUserPost);

export { postRouter };
