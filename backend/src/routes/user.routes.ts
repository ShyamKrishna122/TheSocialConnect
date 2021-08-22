import Router from "express";
import { UserController } from "../controllers/user.controller";

const authRouter = Router();

//!POST
authRouter.post("/signUp", UserController.signUp);

//!POST
authRouter.post("/login", UserController.login);

//!GET
authRouter.get("/fetchUsers", UserController.fetchAllUsers);

//!GET
authRouter.get("/myPosts/:userEmail", UserController.showMyPosts);

export { authRouter };
