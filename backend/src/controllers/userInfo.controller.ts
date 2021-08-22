import { Request, Response } from "express";
import { getManager } from "typeorm";
import { UserInfoRepository } from "../database/userInfo/repository/userInfo.repository";

export class UserInfoController {
  static async addUserInfo(req: Request, res: Response) {
    let userInfoConnectionManager =
      getManager().getCustomRepository(UserInfoRepository);
    await userInfoConnectionManager.addUserInfo(req, res);
  }

  static async showUserInfo(req: Request, res: Response) {
    let userInfoConnectionManager =
      getManager().getCustomRepository(UserInfoRepository);
    await userInfoConnectionManager.showUserInfo(req, res);
  }

  static async updateUserInfo(req: Request, res: Response) {
    let userInfoConnectionManager =
      getManager().getCustomRepository(UserInfoRepository);
    await userInfoConnectionManager.updateUserInfo(req, res);
  }
}
