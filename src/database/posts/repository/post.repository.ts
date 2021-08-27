import { Request, Response } from "express";
import { EntityRepository, getCustomRepository, Repository } from "typeorm";
import { FollowRepository } from "../../followers/repository/follow.repository";
import { UserRepository } from "../../user/repository/user.repository";
import { PostEntity } from "../entity/post.entity";

@EntityRepository(PostEntity)
export class PostRepository extends Repository<PostEntity> {
  //!Add a new post
  async addPost(req: Request, res: Response) {
    let { userEmail } = req.params;
    let { postTitle, postDescription, postMedia, type, imageType } = req.body;

    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({
      userEmail: userEmail,
    });

    try {
      let post = new PostEntity();
      post.postTitle = postTitle;
      post.postDescription = postDescription;
      post.postMedia = postMedia;
      post.type = type;
      post.imageType = imageType;
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

  //!get posts of the people you follow

  async getPosts(req: Request, res: Response) {
    let { userEmail } = req.params;
    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({
      userEmail: userEmail,
    });

    let followRepo = getCustomRepository(FollowRepository);

    try {
      let subQuery = followRepo
        .createQueryBuilder("ScFollow")
        .select("ScFollow.followerId", "fId")
        .where("ScFollow.userId = :id", { id: user?.id });

      let postData = await this.createQueryBuilder("ScPosts")
        .select("*")
        .leftJoinAndSelect("ScPosts.user", "user")
        .leftJoinAndSelect("user.info", "info")
        .where("ScPosts.userId IN (" + subQuery.getQuery() + ")")
        .orderBy("ScPosts.postTime", "DESC")
        .setParameters(subQuery.getParameters())
        .getRawMany();

      let posts = postData.map((p: any) => {
        const post: any = {
          postId: p.postId,
          postTitle: p.postTitle,
          postDescription: p.postDescription,
          postTime: p.postTime,
          postMedia: p.postMedia.split(","),
          postType: p.postType,
          userId: p.userId,
          userName: p.userName,
          userDp: p.userDp,
        };
        return post;
      });
      return res.send({
        received: true,
        message: posts,
      });
    } catch (error) {
      console.log(error);
      return res.send({
        received: false,
        message: "Something Went Wrong",
      });
    }
  }
}
