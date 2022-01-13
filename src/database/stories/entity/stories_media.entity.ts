import { BaseEntity, Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { StoryEntity } from "./stories.entity";

@Entity("ScStoryMedia")
export class StoryMediaEntity extends BaseEntity {
    @PrimaryGeneratedColumn()
    storyMediaId!: string;

    @Column({
        nullable: false,
    })
    mediaType!: string;

    @Column({
        nullable: false,
    })
    mediaUrl!: string;

    @ManyToOne(() => StoryEntity, (story) => story.storyMedia, { onDelete: 'CASCADE' })
    story!: StoryEntity;

}