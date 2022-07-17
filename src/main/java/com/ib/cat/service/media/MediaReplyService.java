package com.ib.cat.service.media;

import com.ib.cat.dto.media.ContentReplyDto;
import com.ib.cat.dto.media.ReviewDto;
import com.ib.cat.entity.ContentReply;
import com.ib.cat.entity.Member;
import com.ib.cat.repository.MediaReplyRepository;
import com.ib.cat.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class MediaReplyService {
    @Autowired
    MediaReplyRepository mediaReplyRepository;

    @Autowired
    MemberRepository memberRepository;

    //*      MediaContentController       *//
    /*  contents - 리뷰 로딩 (contentsService랑 같이 작동) */
//    public List<ContentReplyDto> getMediaReplyPage(int contentsNum, int code)  {
//        List<ContentReply> tmp = mediaReplyRepository.findByContentsNumAndCode(contentsNum, code);
//        System.out.println("Servie - List<ContentReply> tmp:"+tmp);
//        List<ContentReplyDto> list = new ArrayList<>();
//
//        for (ContentReply contentReply : tmp) {
//            ContentReplyDto crd = new ContentReplyDto(
//                    contentReply.getContentsNum(),
//                    contentReply.getWriter(), contentReply.getContent(),
//                    contentReply.getTitle(),
//                    contentReply.getCode()
//            );
//            list.add(crd);
//        }
//        return list;
//    }
    //*      MediaReplyController     *//
    /*  content 상세 페이지  :  리뷰 쓰기 (로그인 한 사람)  */
    public void writeMediaReply(ContentReplyDto dto) {
        ContentReply result = new ContentReply();
        result.setContentsNum(dto.getContentsNum());
        result.setWriter(dto.getWriter());
        result.setTitle(dto.getTitle());
        result.setContent(dto.getContent());
        result.setCode(dto.getCode());

        mediaReplyRepository.save(result);
    }



//    /*  content 상세 페이지  :  리뷰 수정   */
//    public void modifyMediaReply(ContentReply reply) {
//        mediaReplyRepository.save(reply);
//    }
//    /*  content 상세 페이지  :  리뷰 삭제   */
//    public void deleteMediaReply(ContentReply reply){
//        mediaReplyRepository.delete(reply);
//    }

    //*     infoController     *//
    /*   info : 사용자별 작성 리뷰 로딩 (전체)   */
    public List<ContentReply> getMediaReplyList(String id) {
        List<ContentReply> contentReplies
                = mediaReplyRepository.findByWriter(id);
        return contentReplies;
    }

    /*   info : 사용자별 작성 리뷰 로딩 (type-code별)   */
    public List<ContentReply> getMediaReplyListByCode(String id, int code) {
        List<ContentReply> contentReplies
                =mediaReplyRepository.findByWriterAndCode(id, code);
        return contentReplies;
    }

    /*   info : 사용자별 작성 리뷰 갯수    */
    public Long getMediaReplyCount(String id) {
        Long count = mediaReplyRepository.countByWriter(id);
        return count;
    }

    /*   info : 사용자별 작성 리뷰 갯수 by type   */
    public Long getMediaReplyCountByCode(String id, int code) {
        Long count = mediaReplyRepository.countByWriterAndCode(id,code);
        return count;
    }

    /* 호선 추가  */
    /* 1. DB 저장 */
    public void insert(ReviewDto reviewDto){
        ContentReply contentReply = new ContentReply();
        contentReply.setContentsNum(reviewDto.getContentsNum()); contentReply.setWriter(reviewDto.getWriter());
        contentReply.setTitle(reviewDto.getTitle()); contentReply.setContent(reviewDto.getContent());
        contentReply.setCode(reviewDto.getCode());

        mediaReplyRepository.save(contentReply);
    }
    /* 2. Select */
    public List<ReviewDto> getReviews(int contentsNum, int code){
        List<ReviewDto> list = new ArrayList<>();
        List<ContentReply> tmp = mediaReplyRepository.findByContentsNumAndCodeOrderByNoDesc(contentsNum,code);

        for (ContentReply contentReply : tmp){
            Member member = memberRepository.findByName(contentReply.getWriter());
            String img = member.getImgs();

            ReviewDto reviewDto = new ReviewDto(
                    contentReply.getNo(),contentReply.getContentsNum(),contentReply.getWriter(),
                    contentReply.getContent(),contentReply.getTitle(),contentReply.getNo(),img,
                    contentReply.getRegdate()
            ); list.add(reviewDto);
        }

        return list;
    }
    /* 3. Delete */
    public void delete(int no){
        Optional<ContentReply> contentReply = mediaReplyRepository.findById(no);
        if(contentReply.isPresent())
            mediaReplyRepository.delete(contentReply.get());
    }
}
