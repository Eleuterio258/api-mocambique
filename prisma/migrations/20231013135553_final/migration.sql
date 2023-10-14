/*
  Warnings:

  - You are about to drop the column `expiresIn` on the `refresh_token` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `refresh_token` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[user_id]` on the table `refresh_token` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `expires_in` to the `refresh_token` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `refresh_token` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "refresh_token" DROP CONSTRAINT "refresh_token_userId_fkey";

-- DropIndex
DROP INDEX "refresh_token_userId_key";

-- AlterTable
ALTER TABLE "refresh_token" DROP COLUMN "expiresIn",
DROP COLUMN "userId",
ADD COLUMN     "expires_in" INTEGER NOT NULL,
ADD COLUMN     "user_id" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "document" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "document_type" TEXT NOT NULL,
    "document_number" TEXT NOT NULL,
    "expiration_date" TIMESTAMP(3) NOT NULL,
    "side_image_url_document" TEXT NOT NULL,
    "front_image_url_document" TEXT NOT NULL,
    "self_image" TEXT NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "document_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "refresh_token_user_id_key" ON "refresh_token"("user_id");

-- AddForeignKey
ALTER TABLE "refresh_token" ADD CONSTRAINT "refresh_token_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "document" ADD CONSTRAINT "documents_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION;
