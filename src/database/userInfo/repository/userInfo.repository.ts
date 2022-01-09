import { Response, Request } from "express";
import { EntityRepository, getCustomRepository, Repository } from "typeorm";
import { UserRepository } from "../../user/repository/user.repository";
import { UserInfoEntity } from "../entity/userInfo.entity";

@EntityRepository(UserInfoEntity)
export class UserInfoRepository extends Repository<UserInfoEntity> {
  //! add user info
  async addUserInfo(req: Request, res: Response) {
    let { userEmail, name, userDp, userBio } = req.body;

    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({ userEmail: userEmail });

    try {
      let userInfo = new UserInfoEntity();
      userInfo.name = name;
      userInfo.userDp = userDp;
      userInfo.userBio = userBio;
      userInfo.user = user!;
      await userInfo.save();
      return res.send({
        message: "User Info Added",
        added: true,
      });
    } catch (error) {
      return res.send({
        added: false,
        message: "Something went wrong",
      });
    }
  }

  //! Show user info
  async showUserInfo(req: Request, res: Response) {
    let { userEmail } = req.params;
    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({ userEmail: userEmail });

    try {
      let userInfoData = await this.createQueryBuilder("info")
        .leftJoinAndSelect("info.user", "user")
        .where("info.userId = :id", { id: user?.id })
        .getOne();
      if (userInfoData !== undefined) {
        return res.send({
          data: userInfoData,
          received: true,
        });
      } else {
        return res.send({
          data: "Fill some info",
          received: true,
        });
      }
    } catch (error) {
      console.log(error)
      return res.send({
        data: "Something went wrong",
        received: false,
      });
    }
  }

  //! Update User Info

  async updateUserInfo(req: Request, res: Response) {
    let { userEmail } = req.params;
    let { name, userDp, userBio } = req.body;
    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({ userEmail: userEmail });
    let info = await this.findOne({ user: user });
    try {
      await this.createQueryBuilder()
        .update(UserInfoEntity)
        .set({
          name: name,
          userDp: userDp,
          userBio: userBio,
        })
        .where("id = :id", { id: info?.id })
        .execute()
        .then((updatedData: any) => {
          return res.send({
            updated: true,
            data: updatedData,
          });
        });
    } catch (error) {
      console.log(error)
      return res.send({
        updated: false,
        data: "Something went wrong",
      });
    }
  }
}
