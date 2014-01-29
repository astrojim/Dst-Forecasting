directoryname = 'MatFiles';
basename = 'ThreePopL500Samp500';
for Bxy = [0.01 0.1 0.5]
	for Byx = [0.01 0.1 0.5]
		for Byz = [0.01 0.1 0.5]
			for Bzy =[0.01 0.1 0.5]
				for Bzx = [0.01 0.1 0.5]
					for Bxz =[0.01 0.1 0.5]

                        for iter = [1:1:10]
                            if( Bxy == 0.01 )
                                filename = sprintf('%s/%sBxy%.2f',directoryname,basename,Bxy);
                            else
                                filename = sprintf('%s/%sBxy%.1f',directoryname,basename,Bxy);
                            end;
                            if( Byx == 0.01 )
                                filename = sprintf('%sByx%.2f',filename,Byx);
                            else
                                filename = sprintf('%sByx%.1f',filename,Byx);
                            end;
                            if( Byz == 0.01 )
                                filename = sprintf('%sByz%.2f',filename,Byz);
                            else
                                filename = sprintf('%sByz%.1f',filename,Byz);
                            end;
                            if( Bzy == 0.01 )
                                filename = sprintf('%sBzy%.2f',filename,Bzy);
                            else
                                filename = sprintf('%sBzy%.1f',filename,Bzy);
                            end;
                            if( Bxz == 0.01 )
                                filename = sprintf('%sBxz%.2f',filename,Bxz);
                            else
                                filename = sprintf('%sBxz%.1f',filename,Bxz);
                            end;
                            if( Bzx == 0.01 )
                                filename = sprintf('%sBzx%.2f',filename,Bzx);
                            else
                                filename = sprintf('%sBzx%.1f',filename,Bzx);
                            end;
                            
                            filename = sprintf('%s_%i.mat',filename,iter);
                            load(filename);
                            if( iter == 1 )
                                dataXY_combined = dataXY;
                                dataYX_combined = dataYX;
                                dataXZ_combined = dataXZ;
                                dataZX_combined = dataZX;
                                dataZY_combined = dataZY;
                                dataYZ_combined = dataYZ;
                            else
                                dataXY_combined = [dataXY_combined; dataXY];
                                dataYX_combined = [dataYX_combined; dataYX];
                                dataXZ_combined = [dataXZ_combined; dataXZ];
                                dataZX_combined = [dataZX_combined; dataZX];
                                dataZY_combined = [dataZY_combined; dataZY];
                                dataYZ_combined = [dataYZ_combined; dataYZ];
                            end;
                            clear dataXY dataYX dataZX dataXZ dataYZ dataZY;
                        end;
                        savename = sprintf('%s/ThreePopL500Samp100Bxy%.2fByx%.2fByz%.2fBzy%.2fBxz%.2fBzx%.2f_recombined.mat',...
                                directoryname,Bxy,Byx,Byz,Bzy,Bzx,Bxz);
                        save(savename);
                    end;
                end;
            end;
        end;
    end;
end;
                   