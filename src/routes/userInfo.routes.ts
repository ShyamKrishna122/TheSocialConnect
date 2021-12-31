import Router from "express";
import { UserInfoController } from "../controllers/userInfo.controller";

const infoRouter = Router();

//!POST
infoRouter.post("/add", UserInfoController.addUserInfo);

//!GET
infoRouter.get("/:userEmail", UserInfoController.showUserInfo);

//!PUT
infoRouter.put("/update/:userEmail", UserInfoController.updateUserInfo);

export { infoRouter };
