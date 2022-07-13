package com.ib.cat.entity;

import lombok.Builder;
import lombok.Data;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.Entity;
import javax.persistence.Id;

@Data
@Entity(name = "member")
@DynamicInsert
public class Member{
    @Id
    private String id; //MediaLike 테이블 - reference 대상키
    private String pw;
    private String name;
    private String email;
    private String imgo;
    private String imgs;
    private String auth;

    protected Member(){
    }

    @Builder
    public Member(String id, String pw, String name, String email, String imgo, String imgs, String auth){
        this.id=id;
        this.pw=pw;
        this.name=name;
        this.email=email;
        this.imgo=imgo;
        this.imgs=imgs;
        this.auth=auth;
    }

//    @OneToMany(mappedBy="marker")
//    List<Member> members = new ArrayList<>();
}


