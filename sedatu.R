##### LOAD PACKAGES #####
library(tidyverse)

##### LOAD DATA #######
nucleos_certi <- read.csv("/Users/erikaluna/Sync/DAMUSA/convo_sedatu/datos/nucleos_agrarios_certificados.csv")
nucleos_nocerti <- read.csv("/Users/erikaluna/Sync/DAMUSA/convo_sedatu/datos/nucleos_agrarios_nocertificados.csv")

##### Explore data #####
colnames(nucleos_certi) <- c("anio", "cve", "estado", 
                             "ejidatarios", "ejidatarias", "ejidataries",
                             "comuneros", "comuneras", "comuneres",
                             "posesionarios", "posesionarias", "posesionares",
                             "avecindados", "avencidadas", "avecindades",
                             "hombres", "mujeres", "total")

ejidos <- nucleos_certi %>% 
  select(c("anio", "estado", "ejidatarios", "ejidatarias"))
colnames(ejidos) <- c("anio", "estado", "hombres", "mujeres")
ejidos <- ejidos %>% 
  gather("sexo", "n", 3:4)
ejidos$n <- as.numeric(gsub(",","",ejidos$n))
ejidos$propiedad <- "ejido"
str(ejidos)
#ejidos <- ejidos %>% 
  #spread(anio, n)
#write.csv(ejidos, file = "ejidos.csv")

comuni <- nucleos_certi %>% 
  select(c("anio", "estado", "comuneros", "comuneras"))
colnames(comuni) <- c("anio", "estado", "hombres", "mujeres")
comuni <- comuni %>% 
  gather("sexo", "n", 3:4)
comuni$n <- as.numeric(gsub(",","",comuni$n))
comuni$propiedad <- "comunidades"
str(comuni)

poses <- nucleos_certi %>% 
  select(c("anio", "estado", "posesionarios", "posesionarias"))
colnames(poses) <- c("anio", "estado", "hombres", "mujeres")
poses <- poses %>% 
  gather("sexo", "n", 3:4)
poses$n <- as.numeric(gsub(",","",poses$n))
poses$propiedad <- "posesiones"
str(poses)

avec <- nucleos_certi %>% 
  select(c("anio", "estado", "avecindados", "avencidadas"))
colnames(avec) <- c("anio", "estado", "hombres", "mujeres")
avec <- avec %>% 
  gather("sexo", "n", 3:4)
avec$n <- as.numeric(gsub(",","",avec$n))
avec$propiedad <- "avecindad"
str(avec)

nucleos_certi <- rbind(ejidos, comuni, poses, avec)
str(nucleos_certi)

nucleos_certi_nacional <- nucleos_certi %>% 
  group_by(anio, sexo, propiedad) %>% 
  summarise(total = sum(n))

nucleos_certi_spread <- nucleos_certi %>% 
  spread(anio, n)

nucleos_certi_nacional_spread <- nucleos_certi_nacional %>% 
  spread(anio, total)

write.csv(nucleos_certi_spread, file = "nucleos_certi_spread.csv")

write.csv(nucleos_certi_nacional_spread, file = "nucleos_certi_nacional_spread.csv")
write.csv(nucleos_certi_nacional, file = "nucleos_certi_nacional.csv")

#propiedades <- c("ejidos", "comunidades", "posesion", "avecindad")


#nucleos_certi$n <- as.numeric(gsub(",","",nucleos_certi$n))
