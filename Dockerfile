# 베이스 이미지 설정
FROM wordpress:latest

# 추가적으로 필요한 파일 다운로드
RUN apt-get update && apt-get install -y wget unzip

# 필요한 파일 다운로드 및 압축 해제
RUN wget https://example.com/path/to/wordpress/plugins.zip -P /usr/src/wordpress/ && \
    unzip /usr/src/wordpress/plugins.zip -d /usr/src/wordpress/wp-content/plugins/

# 작업 디렉토리 설정
WORKDIR /var/www/html

# 변경된 파일 복사
COPY ./wp-config.php /var/www/html

# 실행할 명령어 설정
CMD ["apache2-foreground"]
