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
    let { postDescription, type, imageType } = req.body;

    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({
      userEmail: userEmail,
    });

    try {
      let post = new PostEntity();
      post.postDescription = postDescription;
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
        .innerJoin("ScPosts.user", "user")
        .innerJoin("user.info", "info")
        .innerJoin("ScPosts.postMedia", "postMedia")
        .innerJoin("postMedia.post", "post")
        .where("ScPosts.userId IN (" + subQuery.getQuery() + ")")
        .orderBy("ScPosts.postTime", "DESC")
        .setParameters(subQuery.getParameters())
        .getRawMany();
      

      let posts = postData.map((p: any) => {
        const post: any = {
          postId: p.postId,
          postDescription: p.postDescription,
          postTime: p.postTime,
          postMediaUrl: p.mediaUrl,
          postMediaType: p.mediaType,
          postType: p.type,
          postImageType: p.imageType,
          userId: p.userId,
          userEmail: p.userEmail,
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

  //! function to delete my post...
  async deleteMyPost(req: Request, res: Response) {
    let { postId } = req.params;
    let { userEmail } = req.body;
    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({ userEmail: userEmail });

    try {
      await this.createQueryBuilder("ScPosts")
        .delete()
        .from(PostEntity)
        .where("postId=:postId", { postId: postId })
        .andWhere("userId=:userId", { userId: user?.id })
        .execute()
        .then((data: any) => {
          return res.send({
            message: "Post removed",
            deleted: true,
          });
        });
    } catch (error) {
      return res.send({
        message: "Something went wrong",
        deleted: false,
      });
    }
  }
}
