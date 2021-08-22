import Router from "express";
import { PostController } from "../controllers/post.controller";

const postRouter = Router();

//!POST
postRouter.post("/add/:userEmail", PostController.addPost);


export { postRouter };
