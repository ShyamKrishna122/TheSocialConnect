import { Request, Response } from "express";
import { EntityRepository, getCustomRepository, Repository } from "typeorm";
import { UserRepository } from "../../user/repository/user.repository";
import { PostEntity } from "../entity/post.entity";

@EntityRepository(PostEntity)
export class PostRepository extends Repository<PostEntity> {
  async addPost(req: Request, res: Response) {
    let { userEmail } = req.params;
    let { postTitle, postDescription, postMedia, postType } = req.body;

    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({
      userEmail: userEmail,
    });

    try {
      let post = new PostEntity();
      post.postTitle = postTitle;
      post.postDescription = postDescription;
      post.postMedia = postMedia;
      post.postType = postType;
      post.user = user!;
      await post.save();
      return res.send({
        message: "Post Added",
        added: true,
      });
    } catch (error) {
      return res.send({
        added: false,
        data: "Something went wrong",
      });
    }
  }

}
