function out=load_database3();
% We load the database the first time we run the program.

persistent loaded;
persistent w;
if(isempty(loaded))
    v=zeros(10304,400);
    for i=1:40
        cd(strcat('s',num2str(i)));
        for j=1:10
            im=strcat(num2str(j),'.pgm');
            k=exist(im);
            faceDetector = vision.CascadeObjectDetector();
            if(k==0)
                im=strcat(num2str(j),'.jpg');
               
                a=imread(im);
                imshow(im)
                BB = step(faceDetector, a);
                %grayImage = rgb2gray(a); 
                ROI =imcrop(a,BB);
                imshow(ROI);
                im=ROI;
                im=imresize(im,[112,92]);
                imwrite(im,(strcat(num2str(j),'.pgm')));
                a=imread(strcat(num2str(j),'.pgm'));
                v(:,(i-1)*10+j)=reshape(a,size(a,1)*size(a,2),1);
               
            else
                 a=imread(im);
                % BB = step(faceDetector, a);
                %grayImage = rgb2gray(a); 
                % ROI =imcrop(a,BB);
                 %%im=ROI;
               % im=imresize(im,[112,92]);
                %imwrite(im,(strcat(num2str(j),'.pgm')));
                 v(:,(i-1)*10+j)=reshape(a,size(a,1)*size(a,2),1);
            end
            
%             if(k>0)
%                 a=imread(im);
%                 v(:,(i-1)*10+j)=reshape(a,size(a,1)*size(a,2),1);
%             else
%                 im=strcat(num2str(j),'.jpg');
%                 a=imread(im);
%                 BB = step(faceDetector, a);
%                 %grayImage = rgb2gray(a); 
%                 ROI =imcrop(a,BB);
%                 im=ROI;
%                 im=imresize(im,[112,92]);
%                 imwrite(im,(strcat(num2str(j),'.pgm')));
%                 a=imread(strcat(num2str(j),'.pgm'));
%                 v(:,(i-1)*10+j)=reshape(a,size(a,1)*size(a,2),1);
%             end
        end
        cd ..
    end
    w=uint8(v); % Convert to unsigned 8 bit numbers to save memory. 
end
loaded=1;  % Set 'loaded' to aviod loading the database again. 
out=w;