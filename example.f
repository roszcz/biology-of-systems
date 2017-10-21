      program example pathway

      implicit real*8 (a-z)
      character cs*25
      integer zy

c     nazwa pliku
       cs='example ss.txt'
       
c      numer pliku
       zy=1

c       czas pocz�tku symulacji
       tt=0
       
c      czas zako�czenia symulacji
       tend=10
       
c      czas zliczania do momentu zapisu danych do pliku
       twrite=0
       
c      d�ugo�� kroku
       tstep=0.01
       
c      czas zmiany
       flok=2

c     strumie� w stanie stacjonarnym (pocz�tkowym)
c      J=10

c      st��enie pierwszego metabolitu A (sta�e)
       A=100

c      pocz�tkowe st��enia metabolit�w B, C, D i E
       B=10
       C=2
       D=5
       E=1

c      sta�e szybko�ci reakcji
       k1=0.1
       k2=1.0
       k3=5.0
       k4=2.0
       k5=10.0

c      r�wnania kinetyczne
       v1=k1*A
       v2=k2*B
       v3=k3*C
       v4=k4*D
       v5=k5*E

c      otwieranie pliku
       open (zy,file=cs,status='old',form='formatted')

c       zapisywanie do pliku
       write(zy,'
     +(e13.4,e13.4,e13.4,e13.4,e13.4,e13.4,e13.4,e13.4,e13.4,e13.4)')
     +tt,B,C,D,E,v1,v2,v3,v4,v5


c     zamkni�cie p�tli (100), wyd�u�anie bie��cego czasu o d�ugo�� kroku
100    tt=tt+tstep

c      przyrost st��e� A, B, C i D w danym kroku
       dB=(v1-v2)*tstep
       dC=(v2-v3)*tstep
       dD=(v3-v4)*tstep
       dE=(v4-v5)*tstep

c      dotychczasowe st��enia B, C, D i E plus przyrost w danym kroku
       B=B+dB
       C=C+dC
       D=D+dD
       E=E+dE

c      r�wnania kinetyczne
       v1=k1*A
       v2=k2*B
       v3=k3*C
       v4=k4*D
       v5=k5*E

c      zwi�kszanie twrite
     	 twrite=twrite+tstep
     	 
c      je�eli twrite jest wi�ksze/r�wne 0.01 wtedy ...
	 if (twrite.GE.0.01) then
	 
c      zerowanie twrite
       twrite=0
       
c      wy�wietlanie na ekranie
       write(*,*)tt,v5,C
       
c      zapis do pliku
       write(zy,'
     +(e13.4,e13.4,e13.4,e13.4,e13.4,e13.4,e13.4,e13.4,e13.4,e13.4)')
     +tt,B,C,D,E,v1,v2,v3,v4,v5
     
c    koniec "je�eli"
       end if

c      je�eli osi�gni�ty zostanie czas zmiany i jump nie r�wna si� 7.0
      if (tt.GT.flok .AND. jump.NE.7.0) then

c     zapewnianie, �e zmiana b�dzie jednorazowa
      jump=7.0
      
c     zwielokrotnianie stalych szybko�ci
      mult=1.0
c       k1=k1*mult
c       k2=k2*mult
c       k3=k3*mult
c       k4=k4*mult
c       k5=k5*mult
       
c     zwielokrotnianie st��e� metabolit�w
      incr=1.0
c      B=B*incr
c      C=C*incr
c      D=D*incr
c      E=E*incr

c      koniec "je�eli"
      end if

c     je�eli czas jest mniejszy od czasu zako�czenia symulacji, wracamy
c     do linii 100 (zamkni�cie p�tli)

       if (tt.LT.tend) goto 100

c      zamkni�cie pliku
       close(zy)

c      program czeka na wprowadzenie jakiej� cyfry (chodzi o to, �eby
c      wy�wietlanie na ekranie nie znik�o)
       write(*,*) 'Write any number'
       read(*,*) number
       
       end


