#include <curl/curl.h>
#include <stdio.h>

size_t write_data(void *ptr, size_t size, size_t nmemb, FILE *stream) {
    size_t written = fwrite(ptr, size, nmemb, stream);
    return written;
}

int main(void)
{
   CURL *curl;
   char outfilename[100] = "curl";
   FILE *fp;
   curl = curl_easy_init();
   if(curl) {
     fp = fopen(outfilename,"wb");
     curl_easy_setopt(curl, CURLOPT_URL, "http://localhost:9000/libcurl.html");
     curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_data);
     curl_easy_setopt(curl, CURLOPT_WRITEDATA, fp);
     curl_easy_perform(curl);
     curl_easy_cleanup(curl);
     fclose(fp);
   }
   return 0;
}
